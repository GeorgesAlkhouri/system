use async_std::task::sleep;
use bevy::prelude::*;
use bevy_async_task::{AsyncTaskRunner, AsyncTaskStatus};
use std::time::Duration;

use std::f32::consts::TAU;

#[derive(Component)]
struct Rotatable {
	speed: f32,
}

fn main() {
	App::new()
		.add_plugins(DefaultPlugins)
		.add_systems(Startup, setup)
		.add_systems(Update, my_system)
		.add_systems(Update, rotate_cube)
		.run();
}

fn setup(
	mut commands: Commands,
	mut meshes: ResMut<Assets<Mesh>>,
	mut materials: ResMut<Assets<StandardMaterial>>,
) {
	commands.spawn((
		PbrBundle {
			mesh: meshes.add(Mesh::from(shape::Cube { size: 1.0 })),
			material: materials.add(Color::WHITE.into()),
			transform: Transform::from_translation(Vec3::ZERO),
			..default()
		},
		Rotatable { speed: 0.3 },
	));

	commands.spawn(Camera3dBundle {
		transform: Transform::from_xyz(0.0, 10.0, 20.0)
			.looking_at(Vec3::ZERO, Vec3::Y),
		..default()
	});

	commands.spawn(PointLightBundle {
		transform: Transform::from_translation(Vec3::ONE * 3.0),
		..default()
	});
}

fn rotate_cube(
	mut cubes: Query<(&mut Transform, &Rotatable)>,
	timer: Res<Time>,
) {
	for (mut transform, cube) in &mut cubes {
		transform.rotate_y(cube.speed * TAU * timer.delta_seconds());
	}
}

fn my_system(mut task_executor: AsyncTaskRunner<u32>) {
	match task_executor.poll() {
		AsyncTaskStatus::Idle => {
			task_executor.start(long_task());
			println!("Started!");
		}
		AsyncTaskStatus::Pending => {
			// Waiting...
		}
		AsyncTaskStatus::Finished(v) => {
			println!("Received {v}");
		}
	}
}

async fn long_task() -> u32 {
	sleep(Duration::from_millis(1000)).await;
	5
}
