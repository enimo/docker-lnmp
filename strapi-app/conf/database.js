// local conf
module.exports = ({ env }) => ({
  defaultConnection: 'default',
  connections: {
    default: {
      connector: 'bookshelf',
      settings: {
        client: 'mysql',
        host: env('DATABASE_HOST', 'mysql8'),
        port: env.int('DATABASE_PORT', 3306),
        database: env('DATABASE_NAME', 'db'),
        username: env('DATABASE_USERNAME', 'user'),
        password: env('DATABASE_PASSWORD', 'pass'),
        ssl: env.bool('DATABASE_SSL', false),
      },
      options: {}
    },
  },
});
