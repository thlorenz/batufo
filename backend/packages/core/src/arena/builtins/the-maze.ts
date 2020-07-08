import { Level } from '../level'

export default Level.fromLevelString(
  'the maze',
  `
======xxxxxxxxxxx======
=    =xxxxxxxxxxx=    =
=  4 =xxxxxxxxxxx=  3 =xxxxxxxxxxxxx=================
=    =xxxxxxxxxxx=    =xxxxxxxxxxxxx=               =
=    =xxxxxxxxxxx=    =xxxxxxxxxxxxx= +           s =
=    ==========xx=    =============x=               =
=             =xx=                =x=               =
=           + =xx=              + =x=    =======    =
= b           =xx= b              =x=    =  b  =    =
=             =xx=                =x=    = s + =    =
==========    =xx=============    =x=    =     =    =
         =    =xxxxxxxxxxxxxx=    =x=    =b + s=    =
=======xx=    =xxxxxxxxxxxxxx=    =x=    =     =    =
=  b  =xx=    ==============x=    =x=    =  2  =    =
= s + =xx=                 =x=    =x=    =     =    =
=     =xx=                 =x=    =x=    =     =    =
=b + s=xx=  +              =x=    ===    =     =    =
=     =xx=                 =x=           =     =    =
=  1  =xx==============    =x=           =     =    =
=     =xxxxxxxxxxxxxxx=    =x= +         =     =    =
=     =xxxxxxxxxxxxxxx=    =x=           =     =    =
=     ===============x=    =x=============     =    =
=                   =x=    =xxxxxxxxxxxxx=     =    =
=                   =x=    =xxxxxxxxxxxxx=     =    =
=                   =x=    ===============     =    =
=                   =x=                        =    =
================    =x=                        =    =
               =    =x= +                    s =    =
               =    =x=         b   +          =    =
               =    =x==========================    =
               =    =xxxxxxxxxxxxxxxxxxxxxxxxxx=    =
               =    =xxxxxxxxxxxxxxxxxxxxxxxxxx=    =
               =    ============================    =
               =                                    =
               =                                    =
               =                                    =
               = b                                + =
               ======================================
               = b                                + =
               =                                    =
               =                                    =
               =                                    =
               =    ============================    =
               =    =xxxxxxxxxxxxxxxxxxxxxxxxxx=    =
               =    =xxxxxxxxxxxxxxxxxxxxxxxxxx=    =
               =    =x==========================    =
               =    =x=         b   +          =    =
               =    =x= +                    4 =    =
================    =x=                        =    =
=                   =x=                        =    =
=  3                =x=    ===============    s=    =
=                   =x=    =xxxxxxxxxxxxx=     =    =
=                   =x=    =xxxxxxxxxxxxx=     =    =
=     ===============x=    =x=============     =    =
=     =xxxxxxxxxxxxxxx=    =x=           =     =    =
=     =xxxxxxxxxxxxxxx=    =x= +         =     =    =
=  2  =xx==============    =x=           =     =    =
=     =xx=                 =x=           =     =    =
=b + s=xx=  +              =x=    ===    =     =    =
=     =xx=                 =x=    =x=    =     =    =
= s + =xx=                 =x=    =x=    =     =    =
=  b  =xx=    ==============x=    =x=    =  1  =    =
=======xx=    =xxxxxxxxxxxxxx=    =x=    =     =    =
         =    =xxxxxxxxxxxxxx=    =x=    =b + s=    =
==========    =xx=============    =x=    =     =    =
=             =xx=                =x=    = s + =    =
= b           =xx= b              =x=    =  b  =    =
=           + =xx=              + =x=    =======    =
=             =xx=                =x=               =
=    ==========xx=    =============x=               =
=    =xxxxxxxxxxx=    =xxxxxxxxxxxxx= +           s =
=    =xxxxxxxxxxx=    =xxxxxxxxxxxxx=               =
= p  =xxxxxxxxxxx= p  =xxxxxxxxxxxxx=================
=    =xxxxxxxxxxx=    =
======xxxxxxxxxxx======
`
)
