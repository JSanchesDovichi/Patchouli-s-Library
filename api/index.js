const express = require('express')
const app = express()
const port = 3000

const db = require('./database.js')

app.use(express.urlencoded({ extended: true }));

//db.sequelize.sync({ force: true })

app.get('/atualizar_banco_dados', (req, res) => {
  db.sequelize.sync({ force: true })

  res.send("Ok")
})

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/conn_test', async (req, res) => {
  try {
    await db.authenticate();
    res.send("Connection estabilished with success!");
  } catch (error) {
    res.send("Unable to estabilish connection!");
  }
});

/*
app.get('/test_file', (req, res) => {
  res.sendFile("/home/workstation/Projetos/dweb2/Patchoulis_Library/assets/pages/onepiece1.jpg")
});

app.get('/test_file2', (req, res) => {
  res.sendFile("/home/workstation/Projetos/dweb2/Patchoulis_Library/assets/pages/onepiece1_overlay.png")
});
*/

require('./entidades/usuarios/rotas')(app)
require('./entidades/conteudo/rotas')(app)
require('./entidades/traducoes/rotas')(app)
app.use(require('./auth.js'));


/*
const passport = require('passport');
const UserModel = require('./entidades/usuarios/model.js');

const JWTstrategy = require('passport-jwt').Strategy;
const ExtractJWT = require('passport-jwt').ExtractJwt;
*/

/*
let estrategia_jwt = new JWTstrategy({
  secretOrKey: 'TOP_SECRET',
  jwtFromRequest: ExtractJWT.fromAuthHeaderAsBearerToken()
}, function (jwt_payload, next) {
  console.log('payload received', jwt_payload);
  //let user_id = getUser({ id: jwt_payload.id });

  Usuarios.findOne({
    'id': jwt_payload.id
  }).then(users => {
    //res.send(users)
    return done(null, user.token);
  })

  return done(null, false);

  if (user) {
    next(null, user);
  } else {
    next(null, false);
  }
})
*/

/*
const estrategia_jwt = new JWTstrategy(
  {
    secretOrKey: 'TOP_SECRET',
    //jwtFromRequest: ExtractJWT.fromUrlQueryParameter('secret_token')
    jwtFromRequest: ExtractJWT.fromAuthHeaderAsBearerToken()
  },
  async (token, done) => {
    try {
      //TODO: Buscar usuário

      Usuarios.findOne().then( users => {
        //res.send(users)
        return done(users, token.user);
    })

      //return done(null, token.user);
    } catch (error) {
      done(error);
    }
  }
);
*/

/*
passport.use(
  'login',
  new JWTstrategy({
    secretOrKey: 'TOP_SECRET',
    jwtFromRequest: ExtractJWT.fromAuthHeaderAsBearerToken()
  }, function (jwt_payload, next) {
    console.log('payload received', jwt_payload);
    //let user_id = getUser({ id: jwt_payload.id });
  
    Usuarios.findOne({
      'id': jwt_payload.id
    }).then(users => {
      //res.send(users)
      return done(null, user.token);
    })
  
    return done(null, false);
  
    if (user) {
      next(null, user);
    } else {
      next(null, false);
    }
  })
);
*/

/*
const jwt = require('jsonwebtoken');
const Usuarios = require('./entidades/usuarios/model.js');

app.get('/profile', passport.authenticate('login', { session: false }),
  function (req, res) {
    res.send(req.user.profile);
  }
);
*/

/*
app.post(
  '/signup',
  passport.authenticate('signup', { session: false }),
  async (req, res, next) => {
    res.json({
      message: 'Signup successful',
      user: req.user
    });
  }
);
*/

/*
app.post(
  '/login',
  async (req, res, next) => {
    passport.authenticate(
      'login',
      async (err, user, info) => {
        try {
          if (err || !user) {
            const error = new Error('An error occurred.');

            return next(error);
          }

          req.login(
            user,
            { session: false },
            async (error) => {
              if (error) return next(error);

              const body = { _id: user._id, email: user.email };
              const token = jwt.sign({ user: body }, 'TOP_SECRET');

              return res.json({ token });
            }
          );
        } catch (error) {
          return next(error);
        }
      }
    )(req, res, next);
  }
);
*/

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

