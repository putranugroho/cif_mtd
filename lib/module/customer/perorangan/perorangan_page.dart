import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'perorangan_notifier.dart';

class PeroranganPage extends StatelessWidget {
  const PeroranganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PeroranganNotifier(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final n = context.watch<PeroranganNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          n.mode == PeroranganMode.create ? n.steps[n.currentStep].label : 'Data CIF',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildBody(context, n),
      ),
    );
  }

  Widget _buildBody(BuildContext context, PeroranganNotifier n) {
    switch (n.mode) {
      case PeroranganMode.initial:
        return Column(
          children: [
            // ElevatedButton(onPressed: n.startCreate, child: const Text('Tambah CIF')),
            // const SizedBox(height: 12),
            // OutlinedButton(onPressed: n.startSearch, child: const Text('Cari CIF')),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Tambah CIF'),
              onPressed: n.startCreate,
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('Cari CIF'),
              onPressed: n.startSearch,
              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            ),
          ],
        );

      case PeroranganMode.search:
        return Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nomor CIF'),
              onChanged: (v) => n.searchNoCif = v,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Nama CIF'),
              onChanged: (v) => n.searchNamaCif = v,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: n.submitSearch, child: n.isLoading ? const CircularProgressIndicator() : const Text('Cari')),
          ],
        );

      case PeroranganMode.create:
        return Column(
          children: [
            _ProgressBar(),
            Expanded(
              child: ListView(
                children: n.currentFields.map((field) {
                  return _FieldRenderer(
                    key: ValueKey('${n.currentStep}_${field.key}'),
                    field: field,
                  );
                }).toList(),
              ),
            ),
            Row(
              children: [
                if (n.currentStep > 0)
                  Expanded(
                    child: OutlinedButton(onPressed: n.prevStep, child: const Text('Sebelumnya')),
                  ),
                if (n.currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: n.currentStep == n.steps.length - 1 ? () => debugPrint(n.values.toString()) : n.nextStep,
                    child: Text(n.currentStep == n.steps.length - 1 ? 'Simpan' : 'Selanjutnya'),
                  ),
                )
              ],
            )
          ],
        );
    }
  }
}

class _ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final n = context.watch<PeroranganNotifier>();
    return Row(
      children: List.generate(n.steps.length, (i) {
        return Expanded(
          child: Container(
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            color: i <= n.currentStep ? Colors.blue : Colors.grey.shade300,
          ),
        );
      }),
    );
  }
}

class _FieldRenderer extends StatelessWidget {
  const _FieldRenderer({
    super.key,
    required this.field,
  });

  final ExcelField field;

  @override
  Widget build(BuildContext context) {
    final n = context.watch<PeroranganNotifier>();
    final value = n.getValue(field.key);

    Widget input;

    switch (field.type) {
      case FieldType.text:
        final isReadOnly = field.readOnly || field.key == 'no_cif' || (field.key == 'nama_cif' && n.searchNoCif.isNotEmpty);

        input = TextFormField(
          key: ValueKey('${n.currentStep}_${field.key}'),
          initialValue: value,
          readOnly: isReadOnly,
          decoration: InputDecoration(
            labelText: field.label,
          ),
          onChanged: isReadOnly ? null : (v) => n.setValue(field.key, v),
        );
        break;

      case FieldType.date:
        input = InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (picked != null) n.setValue(field.key, picked);
          },
          child: InputDecorator(
            decoration: InputDecoration(labelText: field.label),
            child: Text(
              value == null ? '' : value.toString().substring(0, 10),
            ),
          ),
        );
        break;

      case FieldType.yn:
        input = Row(
          children: ['Y', 'N']
              .map((e) => Expanded(
                    child: RadioListTile(
                      title: Text(e),
                      value: e,
                      groupValue: value,
                      onChanged: (v) => n.setValue(field.key, v),
                    ),
                  ))
              .toList(),
        );
        break;

      case FieldType.dropdown:
        input = DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(labelText: field.label),
          items: field.options!.entries
              .map((e) => DropdownMenuItem(
                    value: e.key,
                    child: Text('${e.key} - ${e.value}'),
                  ))
              .toList(),
          onChanged: (v) => n.setValue(field.key, v),
        );
        break;
    }

    return Padding(padding: const EdgeInsets.only(bottom: 16), child: input);
  }
}
