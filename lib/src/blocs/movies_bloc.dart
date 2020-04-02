import 'package:rxdart/rxdart.dart';

import '../resources/repository.dart';
import '../models/item_model.dart';

class MoviesBloc {
  final _repository = Repository();
  //agregar los datos que obtuvo del servidor en forma de objeto ItemModel y pasarlos a la pantalla de la interfaz de usuario como una secuencia
  final _moviesFetcher = PublishSubject<ItemModel>();

  // Para pasar el objeto ItemModel como flujo,se crea otro método allMovies() cuyo tipo de retorno es Observable
  Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

// acceso a una sola instancia de la clase MoviesBloc a la pantalla de la interfaz de usuario.
final bloc = MoviesBloc();
