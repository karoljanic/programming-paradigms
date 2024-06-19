: gcd ( a b -- gcd )
  dup 			      ( (a,b)->(a,b,b) )
  if 			        ( check if top stack is non-zero (a,b) )
    tuck          ( (a,b)->(b,a,b) )
    mod           ( (b,a,b)->(b,a mod b) )
    recurse 	    ( call gcd recursively gcd(b,a mod b) )
  else			      ( top stack is zero (a,0) )
    drop		      ( remove top stack(0) and return result(a) )
  endif ;		      ( end if )

: sd ( a b c -- t x y )
dup >r            ( (a,b,c)()->(a,b,c)(c) )
rot rot           ( (a,b,c)(c)->(c,a,b)(c) )
2dup              ( (c,a,b)(c)->(c,a,b,a,b)(c) )
gcd               ( (c,a,b,a,b)(c)->(c,a,b,gcd(a,b))(c) )
dup               ( (c,a,b,gcd(a,b))(c)->(c,a,b,gcd(a,b),gcd(a,b))(c) )
0= if             ( gcd(a,b)=0, (c,a,b,gcd(a,b))(c) )
  r>              ( (c,a,b,gcd(a,b))(c)->(c,a,b,gcd(a,b),c)() )
  0= if           ( c=0, (c,a,b,gcd(a,b))() )
    clearstack
    2 0 0
  else            ( c!=0, (c,a,b,gcd(a,b)) )
    clearstack
    0 0 0
  endif
else              ( gcd(a,b) != 0, (c,a,b,gcd(a,b))(c) )
  r@              ( (c,a,b,gcd(a,b))(c)->(c,a,b,gcd(a,b),c)(c) )
  swap            ( (c,a,b,gcd(a,b),c)(c)->(c,a,b,c,gcd(a,b))(c) )
  mod             ( (c,a,b,c,gcd(a,b))(c)->(c,a,b,c mod gcd(a,b))(c) )
  0= invert if    ( c mod gcd(a,b)!=0, (c,a,b)(c) )
    rdrop         ( (c,a,b)(c)-> (c,a,b)() )
    clearstack
    0 0 0
  else            ( c mod gcd(a,b)=0, (c,a,b)(c) )
    dup           ( (c,a,b)(c)-> (c,a,b,b)(c) )
    0= if         ( b=0, (c,a,b)(c) )
      rdrop drop  ( (c,a,b)(c)->(c,a)() )
      /           ( (c,a)()->(c/a)() )
      1 swap 0    ( (c/a)()->(1, c/a, 0)() )
    else          ( b!=0, (c,a,b)(c) )
      2dup        ( (c,a,b)(c)->(c,a,b,a,b)(c) )
      /           ( (c,a,b,a,b)(c)->(c,a,b,a/b)(c) )
      r>          ( (c,a,b,a/b)(c)->(c,a,b,a/b,c)() )
      swap        ( (c,a,b,a/b,c)()->(c,a,b,c,a/b)() )
      >r >r       ( (c,a,b,c,a/b)()->(c,a,b)(a/b,c) )
      2dup        ( (c,a,b)(c)->(c,a,b,a,b)(a/b,c) )
      mod         ( (c,a,b,a,b)(c)->(c,a,b,a%b)(a/b,c) )
      r>          ( (c,a,b,a%b)(c)->(c,a,b,a%b,c)(a/b) )
      >r >r >r    ( (c,a,b,a%b,c)()->(c,a)(a/b,c,a%b,b) )
      2drop       ( (c,a)(c,a%b,b)->()(a/b,c,a%b,b) )
      r> r> r>    ( ()(c,a%b,b)->(b,a%b,c)(a/b) )
      recurse     ( call sd(b,a%b,c)->(t,x1,y1)(a/b) )
      tuck        ( (t,x1,y1)(a/b)->(t,y1,x1,y1)(a/b) )
      r>          ( (t,y1,x1,y1)(a/b)->(t,y1,x1,y1,a/b)() )
      *           ( (t,y1,x1,y1,a/b)()->(t,y1,x1,y1*a/b)() )
      -           ( (t,y1,x1,y1*a/b)()->(t,y1,x1-y1*a/b)() )
    endif
  endif
endif ;


: gcd ( a b -- gcd ) 
dup 
if 
  tuck 
  mod 
  recurse 
else 
  drop 
endif ;

: sd ( a b c -- t x y )
dup >r    
rot rot   
2dup      
gcd       
dup 
0= if 
  r>
  0= if
    clearstack
    2 0 0
  else
    clearstack
    0 0 0
  endif
else
  r@
  swap
  mod
  0= invert if
    rdrop
    clearstack
    0 0 0
  else
    dup
    0= if
      rdrop drop
      /           
      1 swap 0
    else
      2dup
      /
      r>
      swap
      >r >r
      2dup
      mod
      r>
      >r >r >r
      2drop
      r> r> r>
      recurse
      tuck
      r>
      *
      -
    endif
  endif
endif ;
