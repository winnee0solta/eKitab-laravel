@extends('dashboard.layout.base')

@section('content')


<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item active" aria-current="page">Categories</li>
    </ol>
</nav>


<div class="mb-3">

    <button type="button" class="btn btn btn-warning text-white" data-toggle="modal" data-target="#addCategoryModal">
        Add New Category
    </button>
</div>



<div class="card">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table">
                <thead class="text-uppercase">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Name</th>
                        <th scope="col">Image</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @if (!empty($categories))
                    @foreach ($categories as $item)
                    <tr>
                        <th scope="row">{{$loop->index + 1}}</th>
                        <td>{{$item['name']}}</td>
                        <td>
                            <img src="{{asset('/images/categories/'.$item['image'])}}" class="img-fluid"
                                style="height: 90px">
                        </td>
                        <td>
                            <div class="d-flex">
                                <a href="#" class="btn btn-float btn-dark btn-sm ml-1" data-toggle="modal"
                                    data-target="#editCategoryModal-{{$item['id']}}" type="button">
                                    <i class="material-icons">edit</i>
                                </a>
                                <a href="#" class="btn btn-float btn-danger btn-sm ml-1" data-toggle="modal"
                                    data-target="#removeCategoryModal-{{$item['id']}}" type="button">
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
<!-- add Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add New Category</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/dashboard/categories/add" method="POST" enctype="multipart/form-data">
                    {{ csrf_field() }}
                    <div class="form-group">
                        <label>Name</label>
                        <input name="name" required type="text" class="form-control" placeholder="Enter Name">
                    </div>
                    <div class="form-group">
                        <label>Image</label>
                        <input name="image" required type="file" class="form-control">
                    </div>

                    <button type="submit" class="btn btn-primary">Add</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

            </div>
        </div>
    </div>
</div>
<!--!ENDS eadd Modal -->


{{-- edit and remove modal  --}}

@if (!empty($categories))
@foreach ($categories as $item)
<div class="modal fade" id="editCategoryModal-{{$item['id']}}" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit Category</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/dashboard/categories/edit" method="POST" enctype="multipart/form-data">
                    {{ csrf_field() }}
                    <input name="id" required value="{{$item['id']}}" style="display: none">
                    <div class="form-group">
                        <label>Name</label>
                        <input name="name" required type="text" class="form-control" placeholder="Enter Name"
                            value="{{$item['name']}}">
                    </div>

                    <div class="form-group">
                        <label>Image</label>
                        <input name="image" type="file" class="form-control">
                    </div>
 
                    <button type="submit" class="btn btn-primary">Edit Category</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="removeCategoryModal-{{$item['id']}}" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Remove the category?</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/dashboard/categories/remove" method="POST">
                    {{ csrf_field() }}
                    <input name="id" required value="{{$item['id']}}" style="display: none">  
                    <button type="submit" class="btn btn-danger">Remove</button>
                    <button  class="btn btn-dark" data-dismiss="modal">Close</button>
                </form>
            </div> 
        </div>
    </div>
</div>
@endforeach
@endif

{{--!ENDS edit and remove modal  --}}

@endsection