
employeeModule.controller('employeeController', ['$scope', '$http', employeeController]);

function employeeController($scope, $http) {

    $scope.loading = true;

    $http({
        method: "GET",
        url: "/api/employeeservice"
    })
    .then(
        function SuccessRequest(responce) {
            $scope.employees = responce.data;
            $scope.loading = false;
        },
        function ErrorInRequest() {
            $scope.error = "An error has occured while loading.."
            $scope.loading = false;
        }
    );

    $http({
        method: "GET",
        url: "/api/managerservice"
    })
    .then(
        function SuccessRequest(responce) {
            $scope.managers = responce.data;
        },
        function ErrorInRequest() {
            $scope.error = "An error has occured while loading.."
        }
    );


    $scope.toggleEdit = function () {
        this.employee.editMode = !this.employee.editMode;
    }

    $scope.saveEmployee = function () {
        $http.loading = true;
        var obj = this.employee;
        $http.put("/api/employeeservice/" + obj.UserID, obj)
        .then(
            function SuccessRequest(responce) {
                obj.ManagerName = responce.data;
                obj.editMode = false;
                alert('Saved Successfully!');
            },
            function ErrorInRequest() {
                $scope.error = "An Error has occured while saving employee."
                obj.editMode = false;
            }
        );
    }

}