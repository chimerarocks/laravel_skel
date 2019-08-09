# laravel_skel

docker hub image: https://cloud.docker.com/repository/docker/chimerarocks/laravel

*Necessário estar atento a ordem em que os containers são criados*

A partir da versão 3 o docker não é mais responsável pela dependendências 
entre serviços entre containers. Tanto que todos devem rodar independentemente. 
O atributos depends_on serve apenas para indicar a ordenação, para controles mais 
específicos de serviços que rodam dentro do container terá que fazer por conta própria.


Pra isso, então foi criado o dockerize.
Ao utilizar o dockerize é preciso estar atento ao timeout de tentativas. 
Como o dockerize morre depois de concluir, é preciso executar um outro comando que fique
rodando o container. Será necessário criar um script de entrypoint (com permissão de execução) 
para tudo que precisa ser executado pelo container. 

A instalação pelo composer possui um detalhe que se deve estar atento.
O composer install dentro do Dockerfile não funciona, porque o composer.json ainda não 
existe no container. Uma solução seria copiar os arquivos com COPY antes de dar o 
composer install, porém isso não vai funcionar. Você verá que o vendor será apagado, isso 
acontece porque temos um volume no docker-compose que sobrescreve os arquivos.
Quando o Dockerfile é gerado não existe docker-compose a imagem ainda está sendo gerada.

Por isso esses comandos de instalação devem ser colocados no entrypoint