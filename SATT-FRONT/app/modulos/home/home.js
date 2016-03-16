'use strict';

angular.module('myApp.home', ['ngRoute'])

.config(['$routeProvider', function ($routeProvider) {
    $routeProvider.when('/', {
        templateUrl: 'modulos/home/home.html',
        controller: 'HomeCtrl'
    });
}])

.controller('HomeCtrl', ['$scope', function ($scope) {

}]);