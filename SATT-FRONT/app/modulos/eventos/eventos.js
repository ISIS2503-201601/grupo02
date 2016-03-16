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
        url: 'http://uniandes-satt.herokuapp.com/eventos'
    }).then(function successCallback(response) {
        $scope.eventos = response.data;
    }, function errorCallback(response) {
        // called asynchronously if an error occurs
        // or server returns response with an error status.
    });
}]);