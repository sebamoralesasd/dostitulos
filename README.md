# dostitulos

Es una app que genera un título de noticias y lo publica en una cuenta de Twitter dada. El título se recrea en base a otros dos provistos por distintos medios periodísticos.

## Uso
Ejecutar `bundle install` para instalar las dependencias de la app.

Para que la app pueda tuitear, definir las variables de entorno usadas en el cliente de Twitter.
```ruby
def client
  Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV.fetch('TWITTER_APP_CONSUMER_KEY', nil)
    config.consumer_secret     = ENV.fetch('TWITTER_APP_CONSUMER_SECRET', nil)
    config.access_token        = ENV.fetch('TWITTER_ACCESS_TOKEN', nil)
    config.access_token_secret = ENV.fetch('TWITTER_ACCESS_TOKEN_SECRET', nil)
  end
end
```

## TODO
- [ ] Agregar más medios y poder usarlos de forma aleatoria
- [ ] Entorno de test
- [ ] Manejo de errores
- [ ] Logs
- [ ] CI/CD
- [ ] Limitar búsqueda de noticias/tópicos según un valor de entorno dado (v2)
- [ ] Evitar repetición de título generado (v2)
