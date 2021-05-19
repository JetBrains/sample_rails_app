FROM public.ecr.aws/bitnami/ruby:2.7
RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs npm postgresql-client yarn && npm install --global yarn
RUN mkdir /sample_rails_application
WORKDIR /sample_rails_application
COPY Gemfile /sample_rails_application/Gemfile
COPY Gemfile.lock /sample_rails_application/Gemfile.lock
COPY package.json /sample_rails_application/package.json
COPY yarn.lock /sample_rails_application/yarn.lock
RUN gem install bundler -v '2.2.15'
RUN bundle install
RUN yarn install --check-files
COPY . /sample_rails_application
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
