'use strict';

angular.module('myApp.alertas', ['ngRoute'])

.config(['$routeProvider', function ($routeProvider) {
    $routeProvider.when('/alertas', {
        templateUrl: 'modulos/alertas/alertas.html',
        controller: 'AlertasCtrl'
    });
}])

.controller('AlertasCtrl', ['$scope', '$http', '$localStorage', function ($scope, $http, $localStorage) {
    $http({
        method: 'GET',
        //        url: 'http://uniandes-satt.herokuapp.com/alertas'
        url: 'http://localhost:8010/alertas'
        //url: 'http://localhost:8080/alertas',
        headers: {
            "Authorization": $localStorage.userInfo !== undefined ? $localStorage.userInfo.accessToken : null
        }
    }).then(function successCallback(response) {
        $scope.alertas = response.data;
    }, function errorCallback(response) {
        if(response.status == 401) {
            $scope.error = "Oh oh! Parece que requieres permisos que no te han otorgado :(";
        } else {
            $scope.error = "Oh oh! Hubo un problema. Lo sentimos, intenta mas tarde :(";   
        }
    });
}]);