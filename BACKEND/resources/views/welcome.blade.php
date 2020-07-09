@extends('dashboard.layout.base')

@section('content')




<div class="row mb-3">
    <div class="col-12 col-md-6 mt-2">
        <div class="card">
            <div class="card-body">

                <div class="table-responsive">
                    <table class="table">
                        <tbody>
                            <tr>
                                <td class="text-center h4 text-uppercase"> Total Members</td>
                                <td>
                                    {{$total_member_count}}
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="text-center h4 text-uppercase">Present Members</td>
                                <td>
                                    {{$present_count}}
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="text-center h4 text-uppercase">Absent Members</td>
                                <td>
                                    {{$absent_count}}
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="text-center h4 text-uppercase">Total Revenue</td>
                                <td>
                                    {{$total_amount}}
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="text-center h4 text-uppercase">Month Revenue</td>
                                <td>
                                    {{$monthrevenue}}
                                </td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                {{-- <div class="text-center h4 text-uppercase">
                    Total Student
                </div>
                <div class="text-center h1 text-uppercase font-weight-bold">
                    {{$total_member_count}}
            </div> --}}
        </div>
    </div>
</div>

<div class="col-12 col-md-6 mt-2">
    <div class="card">
        <div class="card-body">
            <div class="text-center h4 text-uppercase">
                Attendance
            </div>
            <canvas id="myChart" height="110"></canvas>
        </div>
    </div>
</div>

</div>



<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <h5 class="title h4">Membership Expiry Alert</h5>
                <div class="table-responsive">
                    <table class="table">
                        <thead class="text-uppercase">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Deadline</th>
                                <th scope="col">Fullname</th>
                                <th scope="col">Phone</th>
                                <th scope="col">Address</th>
                            </tr>
                        </thead>
                        <tbody>
                            @if (!empty($expiredMembers))
                            @foreach ($expiredMembers as $item)
                            <tr>
                                <td>{{$loop->index + 1}}</td>
                                <td>{{$item['deadline']}}</td>
                                <td>{{$item['fullname']}}</td>
                                <td>{{$item['phone']}}</td>
                                <td>{{$item['address']}}</td>
                            </tr>
                            @endforeach
                            @endif
                        </tbody>
                    </table>


                </div>
            </div>
        </div>
    </div>
</div>






<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
<script>
    var ctx = document.getElementById('myChart');
var myChart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['Present', 'Absent', ],
        datasets: [{
            label: 'Attendance',
            data: [ {{$present_count}}, {{$absent_count}} ],
            backgroundColor: [
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
            ],
            borderColor: [
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
            ],
            borderWidth: 1
        }]
    }
});
</script>




@endsection