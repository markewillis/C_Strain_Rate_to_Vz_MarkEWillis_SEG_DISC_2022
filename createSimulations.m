function [model] = createSimulations(model)

% create master wavelet at depth

model.Vz = mkTraceRicker(model.z0/model.velocity,model.nsamples,model.dt,model.f0,model.amps);

% make two wavelets apart by GL

model.VzUp = mkTraceRicker((model.z0-model.GL/2)/model.velocity,model.nsamples,model.dt,model.f0,model.amps);
model.VzDn = mkTraceRicker((model.z0+model.GL/2)/model.velocity,model.nsamples,model.dt,model.f0,model.amps);

% create the DAS signal - strain rate
model.strainRate = (model.VzDn - model.VzUp )/model.GL;

% create the vertical particle velocity from the DAS strain rate signal
model.vzFromDAS = -1*cumsum(model.strainRate)*model.dt*model.velocity;

return