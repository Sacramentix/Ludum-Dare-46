package tools;

interface Observer {
    public function notified(sender:{}, ?data:Any) : Void;
}

class Observables {
  static public var observables:Map<{}, Array<Observer>> = new Map();
  
  static public function addObserver(subject:{}, observer:Observer)
  {
    if(!observables.exists(subject))
      observables[subject] = new Array<Observer>();
    observables[subject].push(observer);
  }
  static public function removeObserver(subject:{}, observer:Observer)
  {
    observables[subject].remove(observer);
  }
  static public function removeSubject(subject:{})
    {
      observables.remove(subject);
    }

  
  static public function notify(subject:{}, ?data:Any)
  {
    if(observables.exists(subject))
      for(obs in observables[subject])
        obs.notified(subject, data);
  }
}

class Watcher implements Observer {

    public function new(type:String, callback:Any->Any) {
        onNotif = callback;
    }
    public dynamic function onNotif(para:Any):Any {
        return null;
	  }

    public function notified(sender:{}, ?data:Any) {
        onNotif(data);
    }
}

