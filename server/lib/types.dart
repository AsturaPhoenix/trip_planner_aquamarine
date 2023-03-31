import 'package:aquamarine_server_interface/types.dart';
import 'package:equatable/equatable.dart';

class SimulationTime extends Equatable {
  const SimulationTime(this.schedule, this.timestamp, this.index);
  final SimulationSchedule schedule;
  final HourUtc timestamp;
  final int index;

  @override
  get props => [schedule, timestamp, index];
}

class SimulationSchedule {
  static const forecast = SimulationSchedule(
        description: 'forecast',
        typePrefix: 'f',
        firstHour: 3,
        referenceHour: 0,
        intervalHours: 6,
        coverageHours: 48,
      ),
      nowcast = SimulationSchedule(
        description: 'nowcast',
        typePrefix: 'n',
        firstHour: 3,
        referenceHour: 6,
        intervalHours: 6,
        coverageHours: 6,
      );

  const SimulationSchedule({
    required this.description,
    required this.typePrefix,
    required this.firstHour,
    required this.referenceHour,
    required this.intervalHours,
    required this.coverageHours,
  });
  final String description;
  final String typePrefix;
  final int firstHour;
  final int referenceHour;
  final int intervalHours;
  final int coverageHours;

  @override
  String toString() => description;
}
