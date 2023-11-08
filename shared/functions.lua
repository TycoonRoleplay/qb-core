
-- Adds a job to the table in real time
-- Avoids having to edit the shared/jobs.lua file
function QBCore.Functions.AddJob(data)
    if not data then return false end
    if not data.job or not data.label then return false end
    if not data.grades then
        data.grades = {['0'] = { name = 'Freelancer', payment = 10 }}
    end
    if not data.grades['0'] then
        data.grades['0'] = { name = 'Freelancer', payment = 10 }
    end
    QBShared.Jobs[data.job] = data
end

function QBCore.Functions.RemoveJob(jobName)
    -- Remove job from all players who have it
    
    -- Remove job from table
    --QBShared.Jobs[jobName] = nil
end