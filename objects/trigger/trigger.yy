{
  "$GMObject":"",
  "%Name":"trigger",
  "eventList":[
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"trigger",
  "overriddenProperties":[],
  "parent":{
    "name":"TRIGGER",
    "path":"folders/TOOLS/TRIGGER.yy",
  },
  "parentObjectId":null,
  "persistent":false,
  "physicsAngularDamping":0.1,
  "physicsDensity":0.5,
  "physicsFriction":0.2,
  "physicsGroup":1,
  "physicsKinematic":false,
  "physicsLinearDamping":0.1,
  "physicsObject":false,
  "physicsRestitution":0.1,
  "physicsSensor":false,
  "physicsShape":1,
  "physicsShapePoints":[],
  "physicsStartAwake":true,
  "properties":[
    {"$GMObjectProperty":"v1","%Name":"type","filters":[],"listItems":[
        "TTYPE.ONCE",
        "TTYPE.TOGGLE",
        "TTYPE.HOLD",
        "TTYPE.LOOP",
        "TTYPE.REPEAT",
      ],"multiselect":false,"name":"type","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"TTYPE.ONCE","varType":6,},
    {"$GMObjectProperty":"v1","%Name":"condition_function","filters":[],"listItems":[],"multiselect":false,"name":"condition_function","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"undefined","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"execute_function","filters":[],"listItems":[],"multiselect":false,"name":"execute_function","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"undefined","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"exec_func_param","filters":[],"listItems":[],"multiselect":false,"name":"exec_func_param","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[]","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"sprite_mask","filters":[
        "GMSprite",
      ],"listItems":[],"multiselect":false,"name":"sprite_mask","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"-1","varType":5,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":{
    "name":"spr_trigger",
    "path":"sprites/spr_trigger/spr_trigger.yy",
  },
  "spriteMaskId":null,
  "visible":false,
}