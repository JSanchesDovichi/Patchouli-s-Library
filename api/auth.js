const { Router } = require('express')
const router = Router()

/*
const passport = require('passport');
const localStrategy = require('passport-local').Strategy;

var JwtStrategy = require('passport-jwt').Strategy, ExtractJwt = require('passport-jwt').ExtractJwt;
var opts = {}
opts.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
opts.secretOrKey = 'secret';
opts.issuer = 'accounts.examplesoft.com';
opts.audience = 'yoursite.net';
passport.use(new JwtStrategy(opts, function(jwt_payload, done) {
    Usuarios.findOne({id: jwt_payload.sub}, function(err, user) {
        if (err) {
            return done(err, false);
        }
        if (user) {
            return done(null, user);
        } else {
            return done(null, false);
            // or you could create a new account
        }
    });
}));

router.post('/profile', passport.authenticate('jwt', { session: false }),
    function (req, res) {
        res.send(req.user.profile);
    }
);
*/

const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');// import passport and passport-jwt modules
const passport = require('passport');
const passportJWT = require('passport-jwt');// ExtractJwt to help extract the token
const Usuarios = require('./entidades/usuarios/model');
let ExtractJwt = passportJWT.ExtractJwt;// JwtStrategy which is the strategy for the authentication
let JwtStrategy = passportJWT.Strategy;
let jwtOptions = {}; jwtOptions.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
jwtOptions.secretOrKey = 'sUOpxlh6K8lV/JahuYtN2VRzlrPW4gU24UXqQlud7FY=';

// lets create our strategy for web token
let strategy = new JwtStrategy(jwtOptions, function (jwt_payload, next) {
    console.log('payload received', jwt_payload);

    let user = Usuarios.findOne({ where: { id: jwt_payload.id } });

    if (user) {
        next(null, user);
    } else {
        next(null, false);
    }
});
// use the strategy
passport.use(strategy);

router.use(passport.initialize());

router.post('/login', async function (req, res, next) {
    const { email, senha } = req.body;
    if (email && senha) {
        // we get the user with the name and save the resolved promise returned
        user = await Usuarios.findOne({ where: { email: email } });
        if (!user) {
            res.status(401).json({ msg: 'No such user found', user });
            return
        }

        if (user.senha === senha) {
            // from now on we’ll identify the user by the id and the id is// the only personalized value that goes into our token
            let payload = { id: user.id };
            let token = jwt.sign(payload, jwtOptions.secretOrKey);
            //res.cookie('token', token)
            //res.sendStatus(200)
            res.json({ token: token });
        } else {
            res.status(401).json({ msg: 'Password is incorrect' });
        }
    }
});

// protected route
router.get('/protected', passport.authenticate('jwt', { session: false }), function (req, res) {
    res.json({ msg: 'Congrats! You are seeing this because you are authorized' });
});

module.exports = router;