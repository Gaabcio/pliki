@include('shared.html')

@include('shared.head', ['pageTitle' => 'Kraj'])

<body>
    @include('shared.navbar')

    <div class="container mt-5 mb-5">
        <div class="row mb-1">
            <h1>Kraj</h1>
        </div>
        @include('shared.session-error')

        {{-- ... --}}

    </div>

    @include('shared.footer')
</body>

</html>
