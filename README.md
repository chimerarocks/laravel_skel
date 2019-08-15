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
4. Criar gatilho do repositório
5. Fazer o build
6. Integrar build com pull request no git
    
Não vamos usar o dockerize porque queremos testar cada passo do processo de instalação. 
Nem sempre é preciso, na maioria das vezes, utilizar o docker-compose up. Mas nesse caso vamos fazer para testar cada passo.
Criando um docker-compose especifico para build

Voce pode pedir para o cloudbuild rodar utilizar o Dockerfile ou o cloudbuild.yaml  (cloudbuild da pra fazer teste mais avançados)

Ao criar o gatilho do GCP e dispara verificou-se que o ouve um erro:
> Error response from daemon: manifest for gcr.io/ng-recipe-book-79dc9/docker-compose:latest not found

O problema é que ao puxar a imagem ele está pedindo o docker-compose na imagem já que ele irá executar
> Error response from daemon: manifest for gcr.io/codeedu-jp/docker-compose:latest not found
> gcr.io/codeedu-jp/docker-compose — -f docker-compose.cloudbuild.yaml up -d

Se você perceber ele está pedindo o docker-compose do gcr.io (google cloud registry), mas não está lá.

Toda vez que utilizamos uma imagem do docker registramos no registry do docker-hub, mas agora precisa estar
registrado no registry da google.

Então é preciso buildar uma imagem do docker-compose e coloca-la no registry.

O gcr.io possui diversas imagens que voce pode aproveitar chamando gcr.io/cloud-builders/[comando] git,go,docker.
Essas são públicas, no caso não tem uma do docker-compose pública então vamos criar uma no nosso registry. (gcr.io/$PROJECT_ID)

Então na imagem que criaremos precisamos instalar o docker-compose e no entry point chamar o docker-compose para ser utilizado pelo cbuild

