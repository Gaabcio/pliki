@include('shared.html')

  @include('shared.head', ['pageTitle' => 'Wycieczka '.$trip->name])
  <body>
    @include('shared.navbar')

    <div id="wycieczki" class="container mt-5 mb-5">
        <div class="row m-2 text-center">
          <h1>Wycieczka</h1>
        </div>
        <div class="row d-flex justify-content-center">
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card">
                    <img src="{{ asset('storage/img/'.$trip->img) }}" class="card-img-top">
                    <div class="card-body">
                        <h5 class="card-title">{{ $trip->name }}</h5>
                        <p class="card-text">{{ $trip->description }}</p>
                    </div>
                </div>
            </div>
        </div>
      </div>
    </div>

    @include('shared.footer')
</html>
