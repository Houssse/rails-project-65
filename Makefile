lint: 
	bundle exec rubocop

prepare_test_db:
	bin/rails db:test:prepare

test: prepare_test_db
	# Запуск всех тестов через Minitest
	bin/rails test

test_integration:
	# Запуск интеграционных тестов
	bin/rails test test/integration