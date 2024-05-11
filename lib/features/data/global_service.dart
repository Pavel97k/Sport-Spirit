import 'package:get_it/get_it.dart';
import 'package:sport_spirit/features/data/api/repositories/adminstrators_rep.dart';
import 'package:sport_spirit/features/data/api/repositories/collection_server_rep.dart';
import 'package:sport_spirit/features/data/api/repositories/exercise_criterions_rep.dart';
import 'package:sport_spirit/features/data/api/repositories/exercises_rep.dart';
import 'package:sport_spirit/features/data/api/service/service_api.dart';
import 'package:sport_spirit/features/data/sqlite/repositories/local_collection_lite_rep.dart';
import 'package:sport_spirit/features/data/sqlite/repositories/local_exercises_lite_rep.dart';
import 'package:sport_spirit/features/data/sqlite/service/database.dart';
import 'package:sport_spirit/features/domain/api/cubit/administrator_cubit.dart';
import 'package:sport_spirit/features/domain/api/cubit/collection_server_cubit.dart';
import 'package:sport_spirit/features/domain/api/cubit/exercise_criterions_cubit.dart';
import 'package:sport_spirit/features/domain/api/cubit/exercises_cubit.dart';
import 'package:sport_spirit/features/domain/sqlite/cubit/collection_lite_cubit.dart';
import 'package:sport_spirit/features/domain/sqlite/cubit/exercise_lite_cubit.dart';
import 'package:sport_spirit/features/domain/sqlite/cubit/home_cubit.dart';
import 'package:sport_spirit/features/utils/crypto/crypto_helper.dart';
import 'package:sport_spirit/features/utils/storage/shared_preferences_helper.dart';

final service = GetIt.instance;

Future<void> init() async {
  service.registerLazySingleton<ServiceAPI>(() => ServiceAPI());
  service.registerLazySingleton<DBHelper>(() => DBHelper());
  service.registerLazySingleton<EncryptHelper>(() => EncryptHelper());

  service.registerSingleton<SharedPreferencesHelper>(SharedPreferencesHelper());

  service
      .registerLazySingleton<CollectionServerRep>(() => CollectionServerRep());
  service.registerLazySingleton<CollectionLiteRep>(() => CollectionLiteRep());
  service.registerLazySingleton<AdministratorsRep>(() => AdministratorsRep());
  service.registerLazySingleton<ExercisesRep>(() => ExercisesRep());
  service.registerLazySingleton<ExercisesLiteRep>(() => ExercisesLiteRep());
  service.registerLazySingleton<ExercisesCriterionsRep>(
      () => ExercisesCriterionsRep());

  service.registerSingleton<CollectionServerCubit>(CollectionServerCubit());
  service.registerSingleton<CollectionLiteCubit>(CollectionLiteCubit());
  service.registerSingleton<ExercisesCubit>(ExercisesCubit());
  service.registerSingleton<ExercisesLiteCubit>(ExercisesLiteCubit());
  service.registerSingleton<AdministratorCubit>(AdministratorCubit());
  service.registerSingleton<HomeCubit>(HomeCubit());
  service.registerSingleton<ExerciseCriterionsCubit>(ExerciseCriterionsCubit());
}
