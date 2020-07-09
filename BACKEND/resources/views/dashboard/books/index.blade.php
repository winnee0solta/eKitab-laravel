@extends('dashboard.layout.base')

@section('content')

<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item active" aria-current="page">Books</li>
    </ol>
</nav>

<div class="card">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table">
                <thead class="text-uppercase">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Image</th>
                        <th scope="col">price</th>
                        <th scope="col">author</th>
                        <th scope="col">detail</th>
                        <th scope="col">category</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @if (!empty($books))
                    @foreach ($books as $item)
                    <tr>
                        <th scope="row">{{$loop->index + 1}}</th>
                        <td>{{$item['book']}}</td>
                        <td>
                            <img src="{{asset('/images/books/'.$item['image'])}}" class="img-fluid"
                                style="height: 90px">
                        </td>
                        <td>{{$item['price']}}</td>
                        <td>{{$item['author']}}</td>
                        <td>{{$item['detail']}}</td>
                        <td>{{$item['category']}}</td>
                        <td>
                            <div class="d-flex">
                                <a href="#" class="btn btn-float btn-danger btn-sm ml-1" data-toggle="modal"
                                    data-target="#removeModal-{{$item['id']}}" type="button">
                                    <i class="material-icons">delete</i>
                                </a>
                            </div>
                        </td>
                    </tr>
                    @endforeach
                    @endif
                </tbody>
            </table>


        </div>
    </div>
</div>

@endsection


@section('modal')


{{-- d remove modal  --}}

@if (!empty($books))
@foreach ($books as $item)

<div class="modal fade" id="removeModal-{{$item['id']}}" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Remove the user?</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/dashboard/books/remove" method="POST">
                    {{ csrf_field() }}
                    <input name="id" required value="{{$item['id']}}" style="display: none">
                    <button type="submit" class="btn btn-danger">Remove</button>
                    <button class="btn btn-dark" data-dismiss="modal">Close</button>
                </form>
            </div>
        </div>
    </div>
</div>
@endforeach
@endif

{{--!ENDS e  remove modal  --}}

@endsection
