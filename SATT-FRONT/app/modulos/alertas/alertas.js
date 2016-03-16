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
        url: 'http://uniandes-satt.herokuapp.com/alertas'
    }).then(function successCallback(response) {
        $scope.alertas = response.data;
    }, function errorCallback(response) {
        // called asynchronously if an error occurs
        // or server returns response with an error status.
    });
}]);