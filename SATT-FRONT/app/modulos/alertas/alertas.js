'use strict';

angular.module('myApp.alertas', ['ngRoute'])

.config(['$routeProvider', function ($routeProvider) {
    $routeProvider.when('/alertas', {
        templateUrl: 'modulos/alertas/alertas.html',
        controller: 'AlertasCtrl'
    });
}])

.controller('AlertasCtrl', ['$scope', '$http', function ($scope, $http) {
    $http({
        method: 'GET',
//        url: 'http://uniandes-satt.herokuapp.com/alertas'
        url: 'http://localhost:8010/alertas'
    }).then(function successCallback(response) {
        $scope.alertas = response.data;
    }, function errorCallback(response) {
        console.log("ER0ROOOROROOROROROR");
        $scope.error = "Oh oh! Hubo un problema. Lo sentimos, intenta mas tarde :(";
    });
}]);