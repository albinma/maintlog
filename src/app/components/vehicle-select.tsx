'use client';

import { useState } from 'react';
import {
  Button,
  Key,
  ListBox,
  ListBoxItem,
  Popover,
  Select,
  SelectValue,
} from 'react-aria-components';

export default function VehicleSelect({ vehicleNames }: { vehicleNames: string[] }) {
  const [vehicle, setVehicle] = useState<Key>(vehicleNames[0]);

  return (
    <Select defaultSelectedKey={vehicle} onSelectionChange={(selected) => setVehicle(selected)}>
      <Button className="border border-black p-2">
        <SelectValue defaultValue={vehicle} />
        <span aria-hidden="true">▼</span>
      </Button>
      <Popover className="border border-black p-2 bg-white">
        <ListBox className="p-3 space-y-1 text-sm">
          {vehicleNames.map((vehicleName, index) => (
            <ListBoxItem className="flex p-2" key={index} id={vehicleName}>
              {vehicleName}
            </ListBoxItem>
          ))}
        </ListBox>
      </Popover>
    </Select>
  );
}
