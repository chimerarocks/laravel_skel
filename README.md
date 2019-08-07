# laravel_skel

docker hub image: https://cloud.docker.com/repository/docker/chimerarocks/laravel

*Necessário estar atento a ordem em que os containers são criados*

A partir da versão 3 o docker não é mais responsável pela dependendências 
entre serviços entre containers. Tanto que todos devem rodar independentemente. 
O atributos depends_on serve apenas para indicar a ordenação, para controles mais 
específicos de serviços que rodam dentro do container terá que fazer por conta própria.


Pra isso, então foi criado o dockerize.
Ao utilizar o dockerie é preciso estar atento ao timeout de tentativas.