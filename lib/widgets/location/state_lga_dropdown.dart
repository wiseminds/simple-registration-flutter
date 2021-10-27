import 'package:challenge/models/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dropdown_input.dart';
import 'cubit/location_cubit.dart';

class StateLgaDropdown extends StatefulWidget {
  final Function(Location?)? onStateChanged;
  final Function(Location?)? onLgaChanged;
  final Location? initialLga;
  final Location? initialState;

  const StateLgaDropdown(
      {Key? key,
      this.onStateChanged,
      this.onLgaChanged,
      this.initialLga,
      this.initialState})
      : super(key: key);

  @override
  _StateLgaDropdownState createState() => _StateLgaDropdownState();
}

class _StateLgaDropdownState extends State<StateLgaDropdown> {
  late LocationCubit _cubit;
  bool _stateInitialized = false, _lgaInitialized = false;

  @override
  void initState() {
    _cubit = LocationCubit(onLgaFetched: () {
      if (!_lgaInitialized) {
        setState(() {
          _lgaInitialized = true;
        });
        if (widget.initialLga != null &&
            _cubit.state.lgas?.indexOf(widget.initialLga!) != -1) {
          _cubit.lgaChanged(widget.initialLga);
        }
      }
    }, onStateFetched: () {
      if (!_stateInitialized) {
        setState(() {
          _stateInitialized = true;
        });
        if (widget.initialState != null &&
            _cubit.state.location?.indexOf(widget.initialState!) != -1) {
          _cubit.stateChanged(widget.initialState);
        }
      }
    });
    super.initState();
    _cubit.loadStates();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      bloc: _cubit,
      builder: (context, state) {
        return Column(
          children: [
            GestureDetector(
              onTap: state.location != null ? null : _cubit.loadStates,
              child: AbsorbPointer(
                absorbing: state.location == null,
                child: DropdownInput<Location>(
                  horizontalPadding: EdgeInsets.zero,
                  label: 'State',
                  errorText: (Form.of(context)?.widget.autovalidateMode !=
                              AutovalidateMode.disabled &&
                          state.state == null)
                      ? 'Please select state'
                      : null,
                  value: state.state,
                  isLoading: state.isLoading,
                  onChanged: (s) {
                    _cubit.stateChanged(s);
                    if (widget.onStateChanged != null) {
                      widget.onStateChanged!(s);
                    }
                  },
                  options: [
                    if (state.location != null)
                      for (var item in state.location!)
                        InputItem(item, item.name)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 7),
            DropdownInput<Location>(
              horizontalPadding: EdgeInsets.zero,
              label: 'Lga',
              value: state.lga,
              isLoading: state.isLoading,
              errorText: (Form.of(context)?.widget.autovalidateMode !=
                          AutovalidateMode.disabled &&
                      state.lga == null)
                  ? 'Please select LGA'
                  : null,
              onChanged: (lga) {
                _cubit.lgaChanged(lga);
                if (widget.onLgaChanged != null) widget.onLgaChanged!(lga);
              },
              options: [
                if (state.lgas != null)
                  for (var item in state.lgas!) InputItem(item, item.name)
              ],
            ),
            const SizedBox(height: 7),
          ],
        );
      },
    );
  }
}
