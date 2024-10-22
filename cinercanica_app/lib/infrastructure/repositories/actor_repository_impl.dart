import 'package:cinercanica_app/domain/datasources/actors_datasource.dart';
import 'package:cinercanica_app/domain/entities/actor.dart';
import 'package:cinercanica_app/domain/repository/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {

  final ActorsDatasource datasource;
  ActorRepositoryImpl(this.datasource);


  @override
  Future<List<Actor>> getActorsByMovie(String movieId){
    return datasource.getActorsByMovie(movieId);
  }


}