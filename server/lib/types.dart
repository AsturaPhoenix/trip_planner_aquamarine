import 'package:aquamarine_server_interface/types.dart';
import 'package:equatable/equatable.dart';

class SimulationTime extends Equatable {
  const SimulationTime(this.schedule, this.timestamp, this.index);
  final SimulationSchedule schedule;
  final HourUtc timestamp;
  final int index;

  HourUtc get representedTimestamp =>
      timestamp + index - schedule.referenceHour;

  @override
  get props => [schedule, timestamp, index];

  @override
  String toString() {
    // This is copied from OfsClient, which is separate because it also uses
    // the formatted date components for the URI path.
    final yyyy = timestamp.year.toString(),
        mm = timestamp.month.toString().padLeft(2, '0'),
        dd = timestamp.day.toString().padLeft(2, '0'),
        hh = timestamp.hour.toString().padLeft(2, '0'),
        iii = index.toString().padLeft(3, '0');
    final typePrefix = schedule.typePrefix;

    return '$typePrefix$iii.$yyyy$mm$dd.t${hh}z';
  }
}

class SimulationSchedule {
  /// The first hour of the day at which any simulation is run.
  static const firstHour = 3;

  /// Hours between simulation runs.
  static const intervalHours = 6;

  static const forecast = SimulationSchedule(
        description: 'forecast',
        typePrefix: 'f',
        referenceHour: 0,
        coverageHours: 48,
      ),
      nowcast = SimulationSchedule(
        description: 'nowcast',
        typePrefix: 'n',
        referenceHour: 6,
        coverageHours: 6,
      );

  const SimulationSchedule({
    required this.description,
    required this.typePrefix,
    required this.referenceHour,
    required this.coverageHours,
  });
  final String description;
  final String typePrefix;

  /// The index at which the represented timestamp matches the simulation run
  /// timestamp.
  final int referenceHour;

  final int coverageHours;

  @override
  String toString() => description;
}
