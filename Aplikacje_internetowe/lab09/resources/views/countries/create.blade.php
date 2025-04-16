@include('shared.html')

@include('shared.head', ['pageTitle' => 'Dodaj nowy kraj'])

<body>
    @include('shared.navbar')

    <div class="container mt-5 mb-5">

        @include('shared.session-error')

        <div class="row mt-4 mb-4 text-center">
            <h1>Dodaj nowy kraj</h1>
        </div>

        @include('shared.validation-error')

        <div class="row d-flex justify-content-center">
            <div class="col-6">
                <form method="POST" action="{{ route('countries.store') }}" class="needs-validation" novalidate>
                    @csrf
                    <div class="form-group mb-2">
                        <label for="name" class="form-label">Nazwa</label>
                        <input id="name" name="name" type="text" class="form-control @if ($errors->first('name')) is-invalid @endif" value="{{ old('name') }}">
                        <div class="invalid-feedback">Nieprawidłowa nazwa!</div>
                    </div>
                    <div class="form-group mb-2">
                        <label for="code" class="form-label">Kod</label>
                        <input id="code" name="code" type="text" class="form-control @if ($errors->first('code')) is-invalid @endif" value="{{ old('code') }}">
                        <div class="invalid-feedback">Nieprawidłowy kod!</div>
                    </div>
                    <div class="form-group mb-2">
                        <label for="currency" class="form-label">Waluta</label>
                        <input id="currency" name="currency" type="text" class="form-control @if ($errors->first('currency')) is-invalid @endif" value="{{ old('currency') }}">
                        <div class="invalid-feedback">Nieprawidłowa waluta!</div>
                    </div>
                    <div class="form-group mb-2">
                        <label for="area" class="form-label">Powierzchnia</label>
                        <div class="input-group mb-2">
                            <input id="area" type="number" name="area" min="0" placeholder="0"
                                step="any" class="form-control @if ($errors->first('area')) is-invalid @endif" value="{{ old('area') }}">
                            <span class="input-group-text"> km²</span>
                        </div>
                        <div class="invalid-feedback">Nieprawidłowa powierzchnia!</div>
                    </div>
                    <div class="form-group mb-2">
                        <label for="language" class="form-label">Język</label>
                        <input id="language" name="language" type="text" class="form-control @if ($errors->first('language')) is-invalid @endif" value="{{ old('language') }}">
                        <div class="invalid-feedback">Nieprawidłowy język!</div>
                    </div>
                    <div class="text-center mt-4 mb-4">
                        <input class="btn btn-success" type="submit" value="Wyślij">
                    </div>
                </form>
            </div>
        </div>
    </div>

    @include('shared.footer')
</body>

</html>
