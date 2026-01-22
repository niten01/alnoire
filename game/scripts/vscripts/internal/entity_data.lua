EntityData = EntityData or {}

function EntityData:Init()
    self.entities = require('data.entities')
end

function EntityData:ByName(name)
    return self.entities[name]
end

function EntityData:AllByType(type)
    return self:AllByField('type', type)
end

function EntityData:AllByField(fieldName, fieldValue)
    local result = {}
    for id, ent in pairs(self.entities) do
        if ent[fieldName] == fieldValue then
            result[id] = ent
        end
    end

    return result
end

if not EntityData.initialized then
    EntityData:Init()
    EntityData.initialized = true
end
