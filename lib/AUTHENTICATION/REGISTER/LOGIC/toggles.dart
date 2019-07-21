class Toggle{
  bool _isOn=false;
  Toggle({init}){
    this._isOn=init;
  }
  toggle(){
    print(this.isOn);
    if(this._isOn){
      this._isOn=false;
    }
    else{
      this._isOn=true;
    }
    
   
  }
  get isOn=>_isOn;

}