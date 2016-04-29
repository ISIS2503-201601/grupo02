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

.controller('NuevoEventoCtrl', ['$scope', '$http', '$interval', '$localStorage', function ($scope, $http, $interval, $localStorage) {
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
<<<<<<< HEAD
            url: 'http://uniandes-satt.herokuapp.com/eventos',
            //url: 'http://localhost:8010/eventos',
=======
            //            url: 'http://uniandes-satt.herokuapp.com/eventos',
            url: 'http://localhost:8010/eventos',
            //url: 'http://localhost:8080/eventos',
>>>>>>> origin/master
            data: JSON.stringify($scope.form),
            headers: {
                "Authorization": $localStorage.userInfo !== undefined ? $localStorage.userInfo.accessToken : null
            }
        }).then(function successCallback(response) {
            $scope.mensaje = response.data;
            console.log("Alerta id: " + $scope.mensaje.id);
            if ($scope.mensaje.perfil === "Informativo") {
                $scope.classPerfil = "table-warning";
            }
            $scope.actualizar();
        }, function errorCallback(response) {
            $scope.error = true;
            $scope.defError = response.data;
            if (response.status == 401) {
                $scope.error1 = "Oh oh! Parece que requieres permisos que no te han otorgado :(";
            } else {
                $scope.error1 = "Oh oh! Hubo un problema. Lo sentimos, intenta mas tarde :(";
            }
        }).finally(function () {
            $scope.processingForm = false;
            $scope.sent = true;
        });
    }

    var alerta;
    $scope.actualizar = function () {
        if (angular.isDefined(alerta)) return;

        alerta = $interval(function () {
            if ($scope.mensaje.id != undefined && $scope.mensaje.perfil != "Informativo") {
                $http({
                    method: 'GET',
<<<<<<< HEAD
                    url: 'http://uniandes-satt.herokuapp.com/alertas/'+$scope.mensaje.id,
                    //url: 'http://localhost:8010/alertas/'+$scope.mensaje.id,
=======
                    //                    url: 'http://uniandes-satt.herokuapp.com/alertas/'+$scope.mensaje.id,
                    url: 'http://localhost:8010/alertas/'+$scope.mensaje.id,
                    //url: 'http://localhost:8080/alertas/' + $scope.mensaje.id,
                    headers: {
                        "Authorization": $localStorage.userInfo !== undefined ? $localStorage.userInfo.accessToken : null
                    }
>>>>>>> origin/master
                }).then(function successCallback(response) {
                    $scope.mensaje = response.data;
                    if ($scope.mensaje.perfil === "Informativo") {
                        $scope.classPerfil = "table-warning";
                    }
                }, function errorCallback(response) {
                    $scope.error = true;
                    $scope.defError = response.data;
                    if (response.status == 401) {
                        $scope.error2 = "Oh oh! Parece que requieres permisos que no te han otorgado :(";
                    } else {
                        $scope.error2 = "Oh oh! Hubo un problema. Lo sentimos, intenta mas tarde :(";
                    }
                }).finally(function () {
                    $scope.processingForm = false;
                    $scope.sent = true;
                });
            } else {
                $scope.informativo();
            }
        }, 5000);
    };
    $scope.informativo = function () {
        if (angular.isDefined(alerta)) {
            $interval.cancel(alerta);
            alerta = undefined;
        }
    };
}]);