import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pmm/app/features/configuracao/external/db/table/r_ativ_parada_table.dart';
import 'package:flutter_pmm/app/features/configuracao/infra/datasources/generic_datasource.dart';
import 'package:flutter_pmm/app/features/configuracao/infra/models/r_ativ_parada_model.dart';
import 'package:flutter_pmm/app/shared/database/database.dart';
import 'package:flutter_pmm/app/shared/errors/errors.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'r_ativ_parada_dao.g.dart';

@Injectable(singleton: false)
@UseDao(tables: [RAtivParadaTable])
class RAtivParadaDao extends DatabaseAccessor<DataBase>
    with _$RAtivParadaDaoMixin, GenericDatasource<RAtivParadaModel> {
  RAtivParadaDao(DataBase db) : super(db);

  @override
  Future<int> add(RAtivParadaModel entity) {
    return into(rAtivParadaTable).insert(entity.rAtivParadaTableData());
  }

  @override
  Future<Either<Failure, bool>> addAllGeneric(List list) async {
    late int res;
    for (RAtivParadaModel model in list) {
      res = await add(model);
    }
    if (list.length == res) {
      return right(true);
    } else {
      return left(ErrorInsertBDInternal());
    }
  }

  @override
  Future<Either<Failure, List<RAtivParadaModel>>> getAllGeneric() {
    throw UnimplementedError();
  }
}
