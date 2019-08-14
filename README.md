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

Quanto menos recurso você utilizar numa imagem, melhor a segurança por isso o alpine é melhor.
Ainda nessa questão é importante notar que na produção não é preciso nenhuma ferramenta
de desenvolvimento como composer ou npm por isso é feito o multi-stage building.



** CI **

Google Cloud Platform


As coisas são divididas em projetos.

1. Criar um projeto
2. Installar cli gcloud
3. Habilitar Cloud Build
    > O Cloud Build funciona por gatilhos
    
Não vamos usar o dockerize porque queremos testar cada passo do processo de instalação. 
Nem sempre é preciso, na maioria das vezes, utilizar o docker-compose up. Mas nesse caso vamos fazer para testar cada passo.
Criando um docker-compose especifico para build

Voce pode pedir para o cloudbuild rodar utilizar o Dockerfile ou o cloudbuild.yaml  (cloudbuild da pra fazer teste mais avançados)