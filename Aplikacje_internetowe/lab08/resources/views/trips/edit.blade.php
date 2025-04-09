@include('shared.html')

@include('shared.head', ['pageTitle' => 'Edytuj dane wycieczki'])

<body>
    @include('shared.navbar')

    <div class="container mt-5 mb-5">

        @include('shared.session-error')

        <div class="row mt-4 mb-4 text-center">
            <h1>Edytuj dane wycieczki</h1>
        </div>

        @include('shared.validation-error')

        <div class="row d-flex justify-content-center">
            <div class="col-6">
                <form method="POST" action="{{ route('trips.update', $trip->id) }}" class="needs-validation" novalidate>
                    @csrf
                    @method('PUT')
                    <div class="form-group mb-2">
                        <label for="name" class="form-label">Nazwa</label>
                        <input id="name" name="name" type="text"
                        class="form-control @if ($errors->first('name')) is-invalid @endif" value="{{ $trip->name }}">
                        <div class="invalid-feedback">Nieprawidłowe nazwa!</div>
                    </div>
                    <div class="form-group mb-2">
                        <label for="continent" class="form-label">Kontynent</label>
                        <input id="continent" name="continent" type="text"
                        class="form-control @if ($errors->first('continent')) is-invalid @endif"  value="{{ $trip->continent }}">
                        <div class="invalid-feedback">Nieprawidłowy kontynent!</div>
                    </div>
                    <div class="form-group mb-2">
                        <label for="period" class="form-label">Okres</label>
                        <input id="period" name="period" type="text"
                        class="form-control @if ($errors->first('period')) is-invalid @endif"  value="{{ $trip->period }}">
                        <div class="invalid-feedback">Nieprawidłowa okres!</div>
                    </div>
                    <div class="form-group mb-2">
                        <label for="description" class="form-label">Opis</label>
                        <textarea id="description" name="description" type="text" rows="5"
                        class="form-control @if ($errors->first('description')) is-invalid @endif" >{{ $trip->description }}</textarea>
                        <div class="invalid-feedback">Nieprawidłowy opis!</div>
                    </div>
                    <div class="form-group mb-3">
                        <label for="price" class="form-label">Cena</label>
                        <div class="input-group mb-3">
                            <input id="price" type="number" name="price" min="0" placeholder="0"
                                step="any" class="form-control @if ($errors->first('price')) is-invalid @endif" value="{{ $trip->price }}">
                            <span class="input-group-text"> PLN</span>
                        </div>
                        <div class="invalid-feedback">Nieprawidłowa cena!</div>
                    </div>
                    <div class="form-group mb-2">
                        <label for="img" class="form-label">Nazwa obrazka</label>
                        <input id="img" name="img" type="text"
                        class="form-control @if ($errors->first('img')) is-invalid @endif" value="{{ $trip->img }}">
                        <div class="invalid-feedback">Nieprawidłowa nazwa obrazka!</div>
                    </div>
                    <div class="form-group mb-2">
                        <label for="country_id" class="form-label">Kraj</label>
                        <select id="country_id" name="country_id" class="form-select @if ($errors->first('country_id')) is-invalid @endif">
                            @foreach ($countries as $country)
                                <option value="{{$country->id}}" @if($country->name == $trip->country->name) selected @endif>
                                    {{ $country->name }}
                                </option>
                            @endforeach
                        </select>
                        <div class="invalid-feedback">Nieprawidłowy kraj!</div>
                    </div>
                    <div class="text-center mt-4 mb-4">
                        <input class="btn btn-success" type="submit" value="Wyślij">
                    </div>
                </form>
            </div>
        </div>
    </div>


    @include('shared.footer', ['fixedBottom' => false])
</body>

</html>
