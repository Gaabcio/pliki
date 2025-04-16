@include('shared.html')

@include('shared.head', ['pageTitle' => 'Kraj'])

<body>
    @include('shared.navbar')

    <div class="container mt-5 mb-5">
        <div class="row mb-1">
            <h1>Kraj</h1>
        </div>
        @include('shared.session-error')

        <table class="table table-hover table-striped">
            <tbody>
                <tr>
                    <th scope="col">Nazwa</th>
                    <td>{{ $country->name }}</td>
                </tr>
                <tr>
                    <th scope="col">Kod</th>
                    <td>{{ $country->code }}</td>
                </tr>
                <tr>
                    <th scope="col">Waluta</th>
                    <td>{{ $country->currency }}</td>
                </tr>
                <tr>
                    <th scope="col">Powierzchnia</th>
                    <td>{{ $country->area }} km²</td>
                </tr>
                <tr>
                    <th scope="col">Język</th>
                    <td>{{ $country->language }}</td>
                </tr>
                <tr>
                    <th scope="col"></th>
                    <td><a href="{{ route('countries.edit', $country->id) }}" class="btn btn-primary mb-2">Edycja</a>
                        <form method="POST" action="{{ route('countries.destroy', $country->id) }}">
                            @csrf
                            @method('DELETE')
                                <input type="submit" class="btn btn-danger" value="Usuń"/>
                        </form>
                    </td>
                </tr>
            </tbody>
        </table>

    </div>

    @include('shared.footer')
</body>

</html>
