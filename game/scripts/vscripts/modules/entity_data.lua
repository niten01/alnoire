EntityData = EntityData or {}

function EntityData:Init()
    self.entities = {}
    self.commonForType = {}
    local initData = require('data.entities')
    for type, entities in pairs(initData) do
        local common = entities.__common or {}
        self.commonForType[type] = common
        for name, properties in pairs(entities) do
            if name == "__common" then goto continue end
            properties.name = name
            properties.type = type
            if self.entities[name] then
                error("[???] Non-unique entity name in EntityData: " .. name)
            end
            self:AddCommonProperties(properties)
            self.entities[name] = properties
            ::continue::
        end
    end

    DebugPrint("[ALNOIRE] EntityData loaded " .. TableLength(self.entities) .. " entities")
end

function EntityData:AddCommonProperties(entityData)
    if not entityData.type then
        DebugPrint("[???] Typeless entity: ")
        PrintTable(entityData, 2)
    end
    local common = self.commonForType[entityData.type]
    if not common then return end
    for k, v in pairs(common) do
        if not entityData[k] then
            entityData[k] = v
        end
    end
end

function EntityData:AddEntity(type, name, initProperties)
    local initProperties = initProperties or {}
    local new = extend({ name = name, type = type }, initProperties)
    self:AddCommonProperties(new)
    self.entities[name] = new
    return self.entities[name]
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

return EntityData