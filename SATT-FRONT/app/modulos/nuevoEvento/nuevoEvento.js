'use strict';

angular.module('myApp.nuevoEvento', ['ngRoute'])

.config(['$routeProvider', '$httpProvider', function ($routeProvider, $httpProvider) {
    $routeProvider.when('/nuevoEvento', {
        templateUrl: 'modulos/nuevoEvento/nuevoEvento.html',
        controller: 'NuevoEventoCtrl'
    });
    $httpProvider.defaults.useXDomain = true;
    delete $httpProvider.defaults.headers.common['X-Requested-With'];
}])

.controller('NuevoEventoCtrl', ['$scope', '$http', '$interval', function ($scope, $http, $interval) {
    $scope.error = false;
    $scope.mensaje = "Oh oh! Hubo un problema. Lo sentimos, intenta mas tarde :(";
    $scope.sent = false;
    $scope.formData = {};
    $scope.postForm = function () {
        $scope.processingForm = true;
        $scope.error = false;
        $scope.sent = false;
        $http({
            method: 'POST',
            url: 'http://uniandes-satt.herokuapp.com/eventos',
            //url: 'http://localhost:8010/eventos',
            data: JSON.stringify($scope.form),
        }).then(function successCallback(response) {
            $scope.mensaje = response.data;
            console.log("Alerta id: "+$scope.mensaje.id);
            if ($scope.mensaje.perfil === "Informativo") {
                $scope.classPerfil = "table-warning";
            }
            $scope.actualizar();
        }, function errorCallback(response) {
            $scope.error = true;
            $scope.defError = response.data;
        }).finally(function () {
            $scope.processingForm = false;
            $scope.sent = true;
        });
    }
    
    var alerta;
    $scope.actualizar = function() {
        if ( angular.isDefined(alerta) ) return;
        
        alerta = $interval(function() {
            if ($scope.mensaje.id != undefined && $scope.mensaje.perfil != "Informativo") {
                $http({
                    method: 'GET',
                    url: 'http://uniandes-satt.herokuapp.com/alertas/'+$scope.mensaje.id,
                    //url: 'http://localhost:8010/alertas/'+$scope.mensaje.id,
                }).then(function successCallback(response) {
                    $scope.mensaje = response.data;
                    if ($scope.mensaje.perfil === "Informativo") {
                        $scope.classPerfil = "table-warning";
                    }
                }, function errorCallback(response) {
                    $scope.error = true;
                    $scope.defError = response.data;
                    console.log("ER0ROOOROROOROROROR");
                }).finally(function () {
                    $scope.processingForm = false;
                    $scope.sent = true;
                });
            } else {
                $scope.informativo();
            }
        }, 5000);
    };
    $scope.informativo = function() {
        if (angular.isDefined(alerta)) {
            $interval.cancel(alerta);
            alerta = undefined;
        }
    };
}]);