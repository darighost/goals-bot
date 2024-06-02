/-  channels
/+  default-agent, dbug
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  [%0 values=(list @)]
  ==
+$  card  card:agent:gall
--
%-  agent:dbug
=/  current-goals  `(list [@p @t])`~
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this      .
    default   ~(. (default-agent this %|) bowl)
++  on-init
  ^-  (quip card _this)
  ~&  >  '%bravo initialized successfullyy'
  :_  =.  state  [%0 *(list @)]  this
  :~
    [%pass /some/ilovelove %agent [our.bowl %channels] %watch /]
  ==
++  on-save   on-save:default
++  on-load   on-load:default
++  on-poke   on-poke:default
:: This arm triggered by Behn. Note that we should be checking the wire, since maybe one day
:: we will wait for other stuff here
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ~&  "Behn got back to us...checking current goals"
  ~&  current-goals
  =/  goal  (snag 0 current-goals)
  =/  stated-goal-index  (find [" "] (trip +.goal))
  ?~  stated-goal-index  `this(current-goals (slag 1 current-goals))
  =/  stated-goal  (slag (need stated-goal-index) (trip +.goal))
  =/  nest  [kind=%chat ship=~motluc-nammex name=%goals-bot]
  :_  this(current-goals (slag 1 current-goals))
  =/  memo  :*
    ~[[%inline ~[ship+-.goal (crip "Report on your goal: {stated-goal}")]]]
    author=our.bowl
    sent=now.bowl
  ==
  =/  kind-data  [%chat ~]
  =/  essay  [memo kind-data]
  =/  post-action  [%add essay]
  =/  action  [%post post-action]
  :~  [%pass /some/ilovelove %agent [our.bowl %channels] %poke %channel-action !>([%channel nest action])]
  ==
++  on-watch  on-watch:default
++  on-leave  on-leave:default
++  on-peek   on-peek:default
++  on-agent  
  |=  [=wire =sign:agent:gall]
  ?+  wire  ~&  'found something that matchedn\'t the wire:'  ~&  wire  `this
    [%some %ilovelove ~]
    ?:  ?=(%fact -.sign)
      ?:  ?=(%channel-response -.+.sign)
        =/  post
          !<([nest=[kind=?(%chat %diary %heap) ship=@p name=@tas] r-channel-simple-post:channels] q.cage.sign)
        =/  nest  -.post
        ~&  nest
        ?:  ?=(%post -.+.post)
          =/  post-id  -.+.+.post
          ~&  post-id
          ?:  ?=(%set -.+.+.+.post)
            =/  the-juice  +.+.+.+.+.+.post
            =/  author     author:the-juice
            =/  content-blob    content:the-juice
            =/  content  -.+.-.content-blob
            ?:  ?=(@t content)
              =/  content-index  (find "/goal" (trip content))
              ?~  content-index
                ~&  post  `this
              ?:  !=(0 (need content-index))
                ~&  (need content-index)
                ~&  "The string '/goal' appears in the post, but not at the beginning. Ignoring..."  `this
              ~&  "New goal detected!"
              ~&  author
              ~&  nest
              ~&  content
              :_  this(current-goals `(list [@p @t])`[[author content] current-goals])
              =/  memo  :*
                ~[[%inline ~[(crip "Added {(scow %p author)}'s goal. Will check in 1 hour.")]]]
                author=our.bowl
                sent=now.bowl
              ==
              =/  kind-data  [%chat ~]
              =/  essay  [memo kind-data]
              =/  post-action  [%add essay]
              =/  action  [%post post-action]
              :~  [%pass /some/ilovelove %agent [our.bowl %channels] %poke %channel-action !>([%channel nest action])]
                  [%pass /timers %arvo %b %wait (add now.bowl ~h1)]
              ==
            ~&  post  `this
          ~&  "Received something other than %set"  `this
        ~&  "Received something other than %post..."  `this
      ~&  "Received something other than a %channel-response..."  `this
    ~&  "Received something other than a %fact..."  ~&  sign  `this
  ==
  
++  on-fail   on-fail:default
--