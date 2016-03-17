//
//  MRequestEndPoints.h
//
//  Created by Prabhu Chandrasekaran 16/03/2016.
//

#pragma mark - Error Message

static NSString * const kServerErrorMessage = @"Hubo un error en la respuesta del servidor.";
static NSString * const kServerErrorMessageUserFriendly = @"Hubo un error de comunicación con el servidor. Por favor, pruebe más tarde.";

#pragma mark - Keys

static NSString * const kMarvelPublicKey        = @"6298465264107ae67e9e00c642dcad8a";
static NSString * const kMarvelPrivateKey       = @"556d13a7f4d9cdfc03e439455daa0066c68785a3";

#pragma mark - URL Tags

static NSString * const kTagMarvelCharactersURL = @"http://gateway.marvel.com:80/v1/public/characters";
static NSString * const kTagMarvelComicsURL = @"http://gateway.marvel.com:80/v1/public/characters/%@/comics";

# pragma mark - Marvel tags
static NSString * const kTagMarvelResults           = @"results";
static NSString * const kTagMarvelData              = @"data";
static NSString * const kTagMarvelTotal             = @"total";
static NSString * const kTagMarvelName              = @"name";
static NSString * const kTagMarvelId                = @"id";
static NSString * const kTagMarvelThumbnail         = @"thumbnail";
static NSString * const kTagMarvelPath              = @"path";
static NSString * const kTagMarvelExtension         = @"extension";
static NSString * const kTagMarvelDescription       = @"description";
static NSString * const kTagMarvelTitle             = @"title";

static NSString * const kTagMarvelApikey            = @"apikey";
static NSString * const kTagMarvelTs                = @"ts";
static NSString * const kTagMarvelHash              = @"hash";
static NSString * const kTagMarvelLimit             = @"limit";
static NSString * const kTagMarvelOffSet            = @"offset";
static NSString * const kTagMarvelNameStartsWith    = @"nameStartsWith";