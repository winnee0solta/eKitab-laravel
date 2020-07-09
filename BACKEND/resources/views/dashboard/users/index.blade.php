@extends('dashboard.layout.base')

@section('content')


<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item active" aria-current="page">users</li>
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
                        <th scope="col">Email</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Address</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @if (!empty($users))
                    @foreach ($users as $item)
                    <tr>
                        <th scope="row">{{$loop->index + 1}}</th>
                        <td>{{$item['name']}}</td>
                        <td>{{$item['email']}}</td>
                        <td>{{$item['phone']}}</td>
                        <td>{{$item['address']}}</td>
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

@if (!empty($users))
@foreach ($users as $item)

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
                <form action="/dashboard/users/remove" method="POST">
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