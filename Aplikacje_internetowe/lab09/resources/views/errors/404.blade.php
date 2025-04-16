@include('shared.html')

@include('shared.head', ['pageTitle' => 'Błąd 404'])

<style>
    body {
        background-image: url("../../img/carousel2.jpg");
    }
</style>

<body>
    @include('shared.navbar')

    <div class="container mt-5 mb-5">
        @if (session('error'))
            <div class="row d-flex justify-content-center">
                <div class="alert alert-danger">{{ session('error') }}</div>
            </div>
        @endif
        <div class="row mt-4 mb-4 text-center card">
            <h1 class="display-1 fw-bold">404</h1>
            <h2>
                @if (App::environment('local'))
                    {{ $exception->getMessage() }}
                @else
                    not found
                @endif
            </h2>
        </div>

        @include('shared.validation-error')
    </div>

    @include('shared.footer')
    <script>
        document.getElementById("navbar-user").remove();
    </script>
</body>

</html>

