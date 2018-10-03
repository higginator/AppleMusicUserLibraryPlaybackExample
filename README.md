#  README

TO DO: Add developer token in initialization method of AppleMusicTokenController

For requesting a user's songs from their Apple Music library,
    1) Run App
    2) Authorize using left bar button item
    3) Request songs using right bar button item


This application attempts to play songs from a user's Apple Music library using MPMusicPlayerController.
The id vended by the API is something similiar to: 'i.6xpNYpNSzXB2MO'.
Setting this id to a [MPMusicPlayerController systemMusicPlayer] queue results in a different song being played, or an error and no song played.
The song that is played seems to be another song in a user's Apple Music library.
Look at UserLibrarySongsDataSource.m, collectionView:didSelectItemAtIndexPath:, for setting musicPlayer queue.

Some Error outputs when attempting to play these types of song IDs:
1)
[Middleware] RRC <MPCPlayerRequest 0x1cc0e2200>: Request failed with error: Error Domain=MPRequestErrorDomain Code=1 "(null)" UserInfo={MPRequestUnderlyingErrorsUserInfoKey=(
        "Error Domain=MPCPlayerRequestErrorDomain Code=2000 \"Failed to get playing identifer\" UserInfo={NSDebugDescription=Failed to get playing identifer}"
    )}

2)
Domain=MPMusicPlayerControllerErrorDomain Code=2 "prepareToPlay canceled previous prepareToPlay" UserInfo={NSDebugDescription=prepareToPlay canceled previous prepareToPlay}

