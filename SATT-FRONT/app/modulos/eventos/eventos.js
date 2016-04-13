'use strict';

angular.module('myApp.eventos', ['ngRoute'])

.config(['$routeProvider', function ($routeProvider) {
    $routeProvider.when('/eventos', {
        templateUrl: 'modulos/eventos/eventos.html',
        controller: 'EventosCtrl'
    });
}])

.controller('EventosCtrl', ['$scope', '$http', function ($scope, $http) {
    $http({
        method: 'GET',
//        url: 'http://uniandes-satt.herokuapp.com/eventos'
        url: 'http://localhost:8010/eventos'
    }).then(function successCallback(response) {
        $scope.eventos = response.data;
    }, function errorCallback(response) {
        console.log("ER0ROOOROROOROROROR");
        $scope.error = "Oh oh! Hubo un problema. Lo sentimos, intenta mas tarde :(";
    });
}]);