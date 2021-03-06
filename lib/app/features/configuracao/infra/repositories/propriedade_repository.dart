import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_pmm/app/features/configuracao/domain/entities/propriedade.dart';
import 'package:flutter_pmm/app/features/configuracao/domain/repositories/generic_repository.dart';
import 'package:flutter_pmm/app/features/configuracao/external/db/dao/propriedade_dao.dart';
import 'package:flutter_pmm/app/features/configuracao/external/web/propriedade_datasource.dart';
import 'package:flutter_pmm/app/features/configuracao/infra/models/propriedade_model.dart';
import 'package:flutter_pmm/app/shared/errors/errors.dart';

part 'propriedade_repository.g.dart';

@Injectable(singleton: false)
class PropriedadeRepositoryImpl extends GenericRepository<Propriedade> {
  final PropriedadeDatasourceWeb datasourceWeb;
  final PropriedadeDao datasourceDataBase;

  PropriedadeRepositoryImpl(
    this.datasourceWeb,
    this.datasourceDataBase,
  );

  @override
  Future<Either<Failure, List<Propriedade>>> getAllGeneric() async {
    try {
      var data = await datasourceWeb.getAllGeneric();
      return data.fold(
        (l) => left(l),
        (r) => right(List<PropriedadeModel>.from(
            r.map((e) => PropriedadeModel.fromMap(e)))),
      );
    } catch (e) {
      return Left(ErrorConvertRepository());
    }
  }

  @override
  Future<Either<Failure, bool>> addAllGeneric(List<Propriedade> list) async {
    try {
      var modelList = [];
      for (Propriedade entity in list) {
        PropriedadeModel model = PropriedadeModel(
          idPropriedade: entity.idPropriedade,
          descrPropriedade: entity.descrPropriedade,
        );
        modelList.add(model);
      }
      return await datasourceDataBase.addAllGeneric(modelList);
    } catch (e) {
      return Left(ErrorConvertRepository());
    }
  }
}
