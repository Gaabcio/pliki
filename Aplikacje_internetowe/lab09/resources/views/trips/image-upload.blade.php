@include('shared.html')

@include('shared.head', ['pageTitle' => 'Upload obrazka'])

<body>
    @include('shared.navbar')

    <div class="container mt-5 mb-5">

        @include('shared.session-error')

        <div class="row mb-1 text-center">
            <h1>Przesyłanie obrazków</h1>
        </div>

        @include('shared.validation-error')

        <div class="row d-flex justify-content-center">
            <div class="col-10 col-sm-10 col-md-6 col-lg-4">
                <form method="POST" action="{{ route('trips.image_upload.store') }}" enctype="multipart/form-data">
                    <div class="mb-3">
                        @csrf
                        <label for="formFileMultiple" class="form-label">
                            Przesyłanie kilku (max. 5x) plików:
                        </label>
                        <input name="files[]" class="form-control" type="file" id="formFileMultiple" multiple accept=".jpg, .jpeg">
                    </div>
                    <div class="text-center mt-4 mb-4">
                        <input class="btn btn-primary" type="submit" value="Wyślij">
                    </div>
                </form>
            </div>
        </div>
    </div>

    @include('shared.footer')
</body>

</html>
