import 'dart:io';

import 'package:biblioteca_pessoal/layers/domain/entities/livro_entity.dart';
import 'package:biblioteca_pessoal/layers/domain/repositories/livro_repository.dart';
import 'package:biblioteca_pessoal/layers/domain/usecases/livro_usecase/livro_usecase.dart';

class CreateLivroUsecaseImp implements CreateLivroUsecase {
  final CreateLivroRepository _createLivroRepository;

  CreateLivroUsecaseImp(this._createLivroRepository);

  @override
  Future<bool> call(Livro livro) async {
    return _createLivroRepository(livro);
  }
}

// --------------------------------------------------

class DeleteLivroUsecaseImp implements DeleteLivroUsecase {
  final DeleteLivroRepository _deleteLivroRepository;

  DeleteLivroUsecaseImp(this._deleteLivroRepository);

  @override
  Future<bool> call(String id) async {
    return _deleteLivroRepository(id);
  }
}

// --------------------------------------------------

class GetLivroByIdUsecaseImp implements GetLivroByIdUsecase {
  final GetLivroByIdRepository _getLivroByIdRepository;

  GetLivroByIdUsecaseImp(this._getLivroByIdRepository);

  @override
  Future<Livro> call(String idLivro) async {
    return _getLivroByIdRepository(idLivro);
  }
}

// --------------------------------------------------

class GetLivroByNameUsecaseImp implements GetLivroByNameUsecase {
  final GetLivroByNameRepository _getLivroByNameRepository;

  GetLivroByNameUsecaseImp(this._getLivroByNameRepository);

  @override
  Future<Livro?> call(String titulo) async {
    return _getLivroByNameRepository(titulo);
  }
}

// --------------------------------------------------

class GetLivrosUsecaseImp implements GetLivrosUsecase {
  final GetLivrosRepository _getLivrosRepository;

  GetLivrosUsecaseImp(this._getLivrosRepository);

  @override
  Future<List<Livro>> call(String uidUsuario) async {
    return _getLivrosRepository(uidUsuario);
  }
}

// --------------------------------------------------

class UpdateLivroUsecaseImp implements UpdateLivroUsecase {
  final UpdateLivroRepository _updateLivroRepository;

  UpdateLivroUsecaseImp(this._updateLivroRepository);

  @override
  Future<bool> call(Livro livro) async {
    return _updateLivroRepository(livro);
  }
}

// --------------------------------------------------

class SalvarImagemLivroUsecaseImp implements SalvarImagemLivroUsecase {
  final SalvarImagemLivroRepository _salvarImagemLivroRepository;

  SalvarImagemLivroUsecaseImp(this._salvarImagemLivroRepository);

  @override
  Future<String> call(File imagem) async {
    return _salvarImagemLivroRepository(imagem);
  }
}

// --------------------------------------------------

class PesquisarLivroApiUsecaseImp implements PesquisarLivroApiUsecase {
  final PesquisarLivroApiRepository _pesquisarLivroApiRepository;

  PesquisarLivroApiUsecaseImp(this._pesquisarLivroApiRepository);

  @override
  Future<List<Livro>> call(String titulo) async {
    return _pesquisarLivroApiRepository(titulo);
  }
}
