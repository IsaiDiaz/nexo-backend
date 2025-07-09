/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_248109872")

  // add field
  collection.fields.addAt(8, new Field({
    "hidden": false,
    "id": "select2363381545",
    "maxSelect": 1,
    "name": "type",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "select",
    "values": [
      "Consulta",
      "Sesión",
      "Asesoria",
      "Clase"
    ]
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_248109872")

  // remove field
  collection.fields.removeById("select2363381545")

  return app.save(collection)
})
